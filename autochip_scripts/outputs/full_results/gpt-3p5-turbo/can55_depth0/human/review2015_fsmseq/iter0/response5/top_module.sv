module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

reg [3:0] state;

always @(posedge clk, posedge reset)
begin
    if (reset)
        state <= 0; // Reset to initial state
    else 
        case (state)
            0: if (data) state <= 1;
               else state <= 0;
            1: if (data) state <= 2;
               else state <= 0;
            2: if (data) state <= 3;
               else state <= 0;
            3: if (data) begin
                    state <= 4;
                    start_shifting <= 1;
               end
               else state <= 0;
            4: if (data) state <= 2;
               else state <= 0;
            default: state <= 0;
        endcase
end

endmodule
