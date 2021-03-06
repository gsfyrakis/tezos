(**************************************************************************)
(*                                                                        *)
(*    Copyright (c) 2014 - 2016.                                          *)
(*    Dynamic Ledger Solutions, Inc. <contact@tezos.com>                  *)
(*                                                                        *)
(*    All rights reserved. No warranty, explicit or implicit, provided.   *)
(*                                                                        *)
(**************************************************************************)

open Tezos_hash

(** Exported type *)
type header = {
  shell: Updater.shell_block ;
  proto: proto_header ;
  signature: Ed25519.signature ;
}

and proto_header = {
  mining_slot: mining_slot ;
  seed_nonce_hash: Nonce_hash.t ;
  proof_of_work_nonce: MBytes.t ;
}

and mining_slot = Raw_level_repr.t * Int32.t

val mining_slot_encoding: mining_slot Data_encoding.encoding

(** The maximum size of block headers in bytes *)
val max_header_length: int

(** Parse the protocol-specific part of a block header. *)
val parse_header: Updater.raw_block -> header tzresult

val unsigned_header_encoding:
  (Updater.shell_block * proto_header) Data_encoding.encoding

val forge_header:
  Updater.shell_block -> proto_header -> MBytes.t

