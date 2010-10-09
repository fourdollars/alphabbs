using Gtk;
using Vte;

namespace AlphaBBS
{
    class AlphaBBS : Gtk.Window
    {
        public AlphaBBS ()
        {
            var v = new Terminal();
            v.fork_command(null,null,null,null,false,false,false);
            add (v);
        }

        public static int main (string[] args)
        {
            Gtk.init (ref args);

            var bbs = new AlphaBBS ();
            bbs.show_all ();

            bbs.destroy.connect (Gtk.main_quit);

            Gtk.main ();
            return 0;
        }
    }
}
