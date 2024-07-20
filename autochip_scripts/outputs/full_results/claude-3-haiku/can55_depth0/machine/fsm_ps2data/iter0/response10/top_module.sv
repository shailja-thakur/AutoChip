module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

// Define the state enumeration
typedef enum {BYTE1, BYTE2, BYTE3, DONE} state_t;
state_t state, next_state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= BYTE1;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    // Next state logic
    case (state)
        BYTE1: begin
            if (in[2]) begin
                next_state = BYTE2;
            end
            else begin
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
                next_state = BYTE1;
            end
            else begin
                next_state = DONE;
            end
        end
        default: begin
            next_state = BYTE1;
        end
    endcase
end

always @(posedge clk) begin
    // Output logic
    case (state)
        BYTE1: begin
            out_bytes[23:16] <= in;
        end
        BYTE2: begin
            out_bytes[15:8] <= in;
        end
        BYTE3: begin
            out_bytes[7:0] <= in;
        end
        DONE: begin
            done <= 1'b1;
        end
        default: begin
            done <= 1'b0;
        end
    endcase
end

endmodule
