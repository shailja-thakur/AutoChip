module top_module (
  input c,
  input d,
  output [3:0] mux_in
);

    wire a;
    wire b;

    assign a = c & ~d;
    assign b = ~c & d;

    wire [3:0] mux1;
    wire [3:0] mux2;

    assign mux1 = {2{a}} & {2{~b}} & {2{~c}} & {2{~d}} |
                  {2{~a}} & {2{~b}} & {2{~c}} & {2{d}} |
                  {2{~a}} & {2{b}}  & {2{~c}} & {2{d}} |
                  {2{~a}} & {2{b}}  & {2{c}}  & {2{~d}};

    assign mux2 = {4{~a}} & {4{b}} & {4{~c}} & {4{~d}} |
                  {4{a}}  & {4{~b}} & {4{~c}} & {4{~d}} |
                  {4{~a}} & {4{~b}} & {4{c}}  & {4{~d}} |
                  {4{~a}} & {4{b}}  & {4{~c}} & {4{~d}};

    assign mux_in = {mux1[0], mux2[1], mux1[2], mux1[3]};

endmodule
