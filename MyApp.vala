using Gtk;

namespace ValaTutorial
{
    class MyApp : Gtk.Window
    {
        public MyApp ()
        {
            var button = new Button.with_label ("Click me!");
            add (button); 

            button.clicked.connect (on_clicked);
        }

        private void on_clicked (Gtk.Button button)
        {
            stdout.printf ("Ouch!\n");
        }

        public static int main (string[] args)
        {
            Gtk.init (ref args);

            var app = new MyApp ();
            app.show_all ();

            app.destroy.connect (Gtk.main_quit);

            Gtk.main ();
            return 0;
        }
    }
}
