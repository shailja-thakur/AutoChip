module top_module(
    input clk,
    input d,
    output reg q
);

    reg q_initial; // Define a temporary signal to store the initial value of q

    initial begin
        q_initial = 1'hx; // set initial value of q_initial to 1'hx
    end

    always @(posedge clk) begin
        q <= d; // assign the value of d to q
    end

endmodule
