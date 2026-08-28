package main
import ("fmt"; "net/http"; "os")

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		h, _ := os.Hostname()
		fmt.Fprintf(w, "served by %s\n", h)
	})
	fmt.Println("listening on :8080")
	http.ListenAndServe(":8080", nil)
}
