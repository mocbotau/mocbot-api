import DB from '@utils/DBHandler';
import createErrors from 'http-errors';
import { v4 as uuidv4 } from 'uuid';
import { Warning } from '@interfaces/warnings';
import { createUserGuildID } from '@utils/Misc';

const queryValues = 'WarningID, UserGuildID, Reason, Time, AdminID';

/**
 * Creates a warning for a given user within a particular guild
 * @param {bigint | number} userID The user ID to create a warning for
 * @param {bigint | number} guildID The guild ID the user belongs to
 * @param {string} reason The reason for the warning
 * @param {bigint | number} adminID The adminID who distributed the warning
 * @throws {createErrors<400>} Reason/AdminID is left empty
 * @returns {object} the warning created
 */
export async function createWarning(userID: bigint | number, guildID: bigint | number, reason: string, adminID: bigint | number): Promise<Warning> {
  if (reason === undefined || reason === '') {
    throw createErrors(400, 'Reason cannot be empty.');
  }
  if (adminID === undefined) {
    throw createErrors(400, 'AdminID cannot be empty.');
  }
  const userGuildID: number = await createUserGuildID(guildID, userID);
  const RESULT: Warning = {
    WarningID: uuidv4(),
    UserGuildID: userGuildID,
    Reason: reason,
    Time: Math.floor(Date.now() / 1000),
    AdminID: adminID,
  };
  await DB.execute(`INSERT INTO Warnings (${queryValues}) VALUES (?, ?, ?, FROM_UNIXTIME(?), ?)`, Object.values(RESULT));
  return RESULT;
}

/**
 * Fetches all user warnings from a given guild
 * @param {bigint | number} userID the user ID to fetch warnings for
 * @param {bigint |number} guildID the guild ID the user belongs to
 * @throws {createErrors<404>} if User/Guild ID not found
 * @returns {Array} of warnings belonging to that user
 */
export async function getUserWarnings(userID: bigint | number, guildID: bigint | number): Promise<Warning[]> {
  const result: Warning[] = await DB.records(`SELECT ${queryValues} FROM UserGuildWarnings WHERE GuildID = ? AND UserID = ?`, [guildID, userID]);
  if (result.length === 0) throw createErrors(404, 'User/Guild ID not found in database');
  return result;
}

/**
 * Deletes a given warning ID.
 * @param {string} warningID the warningID to delete
 * @throws {createErrors<404>} Warning ID not found.
 * @returns {}
 */
export async function deleteWarning(warningID: string): Promise<Record<string, never>> {
  if ((await DB.field('SELECT WarningID FROM Warnings WHERE WarningID = ?', [warningID])) === null) {
    throw createErrors(404, 'Warning ID not found');
  }
  await DB.execute('DELETE FROM Warnings WHERE WarningID = ?', [warningID]);
  return {};
}

/**
 * Removes all warnings for a given guild
 * @param {bigint | number} guildID The guild ID to delete warnings from
 * @throws {createErrors<404>} Guild ID not found
 * @returns {}
 */
export async function deleteGuildWarnings(guildID: bigint | number): Promise<Record<string, never>> {
  const result: string[] = await DB.column('SELECT WarningID FROM UserGuildWarnings WHERE GuildID = ?', [guildID]);
  if (result.length === 0) throw createErrors(404, 'Guild ID not found in database');
  await DB.execute('DELETE w FROM Warnings AS w INNER JOIN UserInGuilds u ON w.UserGuildID = u.UserGuildID WHERE u.GuildID = ?', [guildID]);
  return {};
}

/**
 * Fetch all warnings from a given guild
 * @param {bigint | number} guildID The guild ID you'd like to fetch warnings for
 * @throws {createErrors<404>} Guild ID not found
 * @returns {Warning[]} The list of warnings
 */
export async function getGuildWarnings(guildID: bigint | number): Promise<Warning[]> {
  const result: Warning[] = await DB.records(`SELECT ${queryValues} FROM UserGuildWarnings WHERE GuildID = ?`, [guildID]);
  if (result.length === 0) throw createErrors(404, 'Guild ID not found in database');
  return result;
}
