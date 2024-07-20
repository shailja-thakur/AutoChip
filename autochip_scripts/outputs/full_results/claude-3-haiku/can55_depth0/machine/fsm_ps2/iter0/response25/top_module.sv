module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

// Define the states
localparam BYTE1 = 0, BYTE2 = 1, BYTE3 = 2, DONE = 3;

// State register
reg [1:0] state, next_state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= BYTE1;
    end else begin
        state <= next_state;
    end
end

// Next state logic
always @(*) begin
    case (state)
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
    if (state == DONE) begin
        done <= 1'b1;
    end else begin
        done <= 1'b0;
    end
end

endmodule
