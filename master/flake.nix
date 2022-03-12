{
  description = ''Nim wrapper of the Sophia key/value store'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-sophia-master.flake = false;
  inputs.src-sophia-master.owner = "gokr";
  inputs.src-sophia-master.ref   = "refs/heads/master";
  inputs.src-sophia-master.repo  = "nim-sophia";
  inputs.src-sophia-master.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-sophia-master"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-sophia-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}