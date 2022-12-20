import DB from '@utils/DBHandler';
import { createSettings, getSettings, updateSettings, deleteSettings } from '@src/settings';

// Ensure DB is in a predictable state by clearing it initially, then again after every test
// We then close the DB at the end to remove any open handles
beforeAll(async () => {
  await DB.execute('DELETE FROM GuildSettings');
});
afterEach(async () => {
  await DB.execute('DELETE FROM GuildSettings');
});
afterAll(() => DB.close());

describe('Create settings', () => {
  test('Valid', async () => {
    await expect(createSettings(1, { setting1: true })).resolves.not.toThrow();
  });
  test('No settings', async () => {
    await expect(createSettings(1, {})).rejects.toThrow();
  });
  test('Guild already exist', async () => {
    await expect(createSettings(1, { setting1: true })).resolves.not.toThrow();
    await expect(createSettings(1, {})).rejects.toThrow();
  });
});
describe('Get settings', () => {
  test('Valid', async () => {
    await expect(createSettings(1, { setting1: true })).resolves.not.toThrow();
    await expect(getSettings(1)).resolves.not.toThrow();
    expect(await getSettings(1)).toStrictEqual({ setting1: true });
  });
  test('Guild ID does not exist', async () => {
    await expect(getSettings(1)).rejects.toThrow();
  });
});
describe('Update settings', () => {
  test('Valid (single value)', async () => {
    await expect(createSettings(1, { setting1: true, setting2: { a: true, b: false } })).resolves.not.toThrow();
    const FUNC_CALL = await expect(updateSettings(1, { setting2: { a: false } }));

    const EXPECTED = { setting1: true, setting2: { a: false, b: false } };
    FUNC_CALL.resolves.not.toThrow();
    FUNC_CALL.resolves.toStrictEqual(EXPECTED);
  });
  test('Valid (all values)', async () => {
    const EXPECTED = { setting1: false, setting2: { a: false, b: true } };

    await expect(createSettings(1, { setting1: true, setting2: { a: true, b: false } })).resolves.not.toThrow();
    const FUNC_CALL = await expect(updateSettings(1, EXPECTED));

    FUNC_CALL.resolves.not.toThrow();
    FUNC_CALL.resolves.toStrictEqual(EXPECTED);
  });
  test('Guild does not exist', async () => {
    await expect(updateSettings(1, { setting1: true })).rejects.toThrow();
  });
  test('Settings is empty', async () => {
    await expect(createSettings(1, { setting1: true, setting2: { a: true, b: false } })).resolves.not.toThrow();
    await expect(updateSettings(1, {})).rejects.toThrow();
  });
});
describe('Delete settings', () => {
  test('Valid', async () => {
    await expect(createSettings(1, { setting1: true })).resolves.not.toThrow();
    await expect(deleteSettings(1)).resolves.not.toThrow();
    await expect(getSettings(1)).rejects.toThrow();
  });
  test('Guild ID does not exist', async () => {
    await expect(deleteSettings(1)).rejects.toThrow();
  });
});
