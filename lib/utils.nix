{ lib }: { recursiveMergeAttrs = builtins.foldl' lib.recursiveUpdate { }; }
