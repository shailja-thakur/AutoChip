module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    reg [3:0] state;
    reg [3:0] next_state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 4'b0000;
            start_shifting <= 0;
        end
        else begin
            state <= next_state;
            start_shifting <= 0;
            
            case (state)
                4'b0000: if (data) next_state = 4'b0001;
                         else next_state = 4'b0000;
                4'b0001: if (data) next_state = 4'b0011;
                         else next_state = 4'b0000;
                4'b0011: if (data) next_state = 4'b0110;
                         else next_state = 4'b0000;
                4'b0110: if (data) next_state = 4'b1101;
                         else next_state = 4'b0000;
                4'b1101: if (data) next_state = 4'b1101;
                         else begin
                             next_state = 4'b0000;
                             start_shifting <= 1;
                         end
            endcase
        end
    end
endmodule
