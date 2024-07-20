module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

// Define the states
localparam IDLE = 3'b000;
localparam S1 = 3'b001;
localparam S11 = 3'b010;
localparam S110 = 3'b011;
localparam S1101 = 3'b100;

// Declare the state register
reg [2:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        start_shifting <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (data == 1'b1)
                    state <= S1;
                else
                    state <= IDLE;
            end
            S1: begin
                if (data == 1'b1)
                    state <= S11;
                else
                    state <= IDLE;
            end
            S11: begin
                if (data == 1'b0)
                    state <= S110;
                else
                    state <= S1;
            end
            S110: begin
                if (data == 1'b1)
                    state <= S1101;
                else
                    state <= IDLE;
            end
            S1101: begin
                state <= S1101;
                start_shifting <= 1;
            end
            default:
                state <= IDLE;
        endcase
    end
end

endmodule
