import express from 'express';
import asyncHandler from 'express-async-handler';
import { createSettings } from '@src/settings';
import { Request, Response } from 'express';

const router = express.Router();

router.post('/:guild_id', asyncHandler(async (req: Request, res: Response) => {
  res.json(await createSettings(BigInt(req.params.guild_id), req.body));
}));

router.get('/:guild_id', (req, res) => {
  return res.json({});
});
router.patch('/:guild_id', (req, res) => {
  return res.json({});
});

export default router;
