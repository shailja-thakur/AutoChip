module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] current_state;
    
    always @(posedge clk) begin
        if (reset)
            current_state <= 32'h1;
        else
            current_state <= {current_state[30:0], current_state[0] ^ current_state[10] ^ current_state[30] ^ current_state[31]};
    end
    
    assign q = current_state;

endmodule
