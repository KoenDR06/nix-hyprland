{lib, ...}: {
  types = import ./types { inherit lib; };
  converter = import ./converter { inherit lib; };
}
