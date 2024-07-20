module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

// Declare states
typedef enum logic [1:0] {
    BYTE1,
    BYTE2,
    BYTE3,
    DONE
} state_t;

// Declare signals
reg [1:0] current_state, next_state;
wire third_bit;

// Assign third bit
assign third_bit = in[2];

// State machine logic
always_ff @(posedge clk, posedge reset) begin
    if (reset) begin
        current_state <= BYTE1;
    end else begin
        current_state <= next_state;
    end
end

always_comb begin
    case (current_state)
        BYTE1: begin
            if (third_bit) begin
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
            if (third_bit) begin
                next_state = BYTE2;
            end else begin
                next_state = BYTE1;
            end
        end
    endcase
end

// Output logic
assign done = (current_state == DONE);

endmodule
