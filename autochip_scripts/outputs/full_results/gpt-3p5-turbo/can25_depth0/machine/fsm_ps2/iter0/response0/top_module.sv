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
reg [1:0] state;
reg done_reg;

// Next state logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= BYTE1;
        done_reg <= 0;
    end else begin
        case (state)
            BYTE1: begin
                state <= (in[2]) ? BYTE2 : BYTE1;
            end
            BYTE2: begin
                state <= BYTE3;
            end
            BYTE3: begin
                state <= DONE;
            end
            DONE: begin
                state <= (in[2]) ? BYTE2 : BYTE1;
            end
        endcase
    end
end

// Output logic
always @(posedge clk) begin
    done_reg <= (state == DONE);
end

assign done = done_reg;

endmodule
