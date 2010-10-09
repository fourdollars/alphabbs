using Gtk;
using Vte;

namespace AlphaBBS
{
    class AlphaBBS : Dialog
    {
        private Entry site;
        private Entry port;
        private Entry encoding;
        private CheckButton ssh;

        public AlphaBBS ()
        {
            title = "AlphaBBS";
            set_default_size (300, 50);
            set_resizable (false);
            create_widgets ();
            connect_signals ();

            destroy.connect (Gtk.main_quit);
        }

        private void create_widgets ()
        {
            var hbox = new HBox (false, 0);

            var site_frame = new Frame ("Site");
            site = new Entry ();
            site.set_text("ptt.cc");
            site_frame.add (site);

            var port_frame = new Frame ("Port");
            port = new Entry ();
            port.set_text("23");
            port_frame.add (port);

            var encoding_frame = new Frame ("Encoding");
            encoding = new Entry ();
            encoding.set_text("BIG-5");
            encoding_frame.add (encoding);

            ssh = new CheckButton.with_mnemonic ("SSH");

            hbox.pack_start (site_frame, true, true, 0);
            hbox.pack_start (port_frame, true, true, 0);
            hbox.pack_start (encoding_frame, true, true, 0);
            hbox.pack_start (ssh, true, true, 0);

            this.vbox.pack_start (hbox, false, true, 0);
        }

        private void connect_signals ()
        {
            site.activate.connect((entry) => {
                connect_bbs();
            });
            port.activate.connect((entry) => {
                connect_bbs();
            });
            encoding.activate.connect((entry) => {
                connect_bbs();
            });
        }

        private void connect_bbs()
        {
            hide_all ();

            var window = new Window (Gtk.WindowType.TOPLEVEL);
            var v = new Terminal();

            if (ssh.get_active() == true) {
                v.fork_command ("ssh", {"ssh", "-p", port.text, "bbs@" + site.text}, null, null, false, false, false);
            } else {
                v.fork_command ("telnet", {"telnet", "-E", site.text, port.text}, null, null, false, false, false);
            }
            v.set_encoding (encoding.text);
            v.set_size (80, 24);
            //v.set_background_transparent (true);
            window.title = "AlphaBBS - " + site.text;
            window.add (v);
            window.position = WindowPosition.CENTER;
            window.set_resizable (false);
            window.show_all ();
            window.destroy.connect (Gtk.main_quit);
        }

        public static int main (string[] args)
        {
            Gtk.init (ref args);

            var bbs = new AlphaBBS ();
            bbs.show_all ();

            Gtk.main ();
            return 0;
        }
    }
}
