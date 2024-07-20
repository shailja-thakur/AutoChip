module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

// Define the states of the state machine
localparam BYTE1 = 2'b00;
localparam BYTE2 = 2'b01;
localparam BYTE3 = 2'b10;
localparam DONE = 2'b11;

// Declare the current and next state registers
reg [1:0] current_state, next_state;

// State transition logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= BYTE1;
    end else begin
        current_state <= next_state;
    end
end

// Next state logic
always @(*) begin
    case (current_state)
        BYTE1: begin
            if (in[2]) begin
                next_state = BYTE2;
            end else begin
                next_state = BYTE1;
            end
        end
        BYTE2: begin
            next_state = BYTE3;
        end
        BYTE3: begin
            next_state = DONE;
        end
        DONE: begin
            if (in[2]) begin
                next_state = BYTE2;
            end else begin
                next_state = BYTE1;
            end
        end
        default: begin
            next_state = BYTE1;
        end
    endcase
end

// Output logic
always @(posedge clk) begin
    case (current_state)
        DONE: begin
            done <= 1'b1;
        end
        default: begin
            done <= 1'b0;
        end
    endcase
end

endmodule
