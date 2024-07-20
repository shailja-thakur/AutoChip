module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

// Define states
parameter BYTE1 = 2'b00;
parameter BYTE2 = 2'b01;
parameter BYTE3 = 2'b10;
parameter DONE = 2'b11;

// Registers
reg [1:0] state_reg;
reg [7:0] input_reg;
reg done_reg;

// Next state logic
always @(posedge clk, posedge reset) begin
    if (reset)
        state_reg <= BYTE1;
    else begin
        case(state_reg)
            BYTE1: begin
                if (in[2] == 1)
                    state_reg <= BYTE2;
                else
                    state_reg <= BYTE1;
            end
            BYTE2: state_reg <= BYTE3;
            BYTE3: state_reg <= DONE;
            DONE: begin
                if (in[2] == 1)
                    state_reg <= BYTE2;
                else
                    state_reg <= BYTE1;
            end
        endcase
    end
end

// Output logic
always @(posedge clk) begin
    case(state_reg)
        DONE: done_reg <= 1'b1;
        default: done_reg <= 1'b0;
    endcase
end

// Assign outputs
assign done = done_reg;

endmodule
