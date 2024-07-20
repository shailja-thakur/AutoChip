module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

// Define state enumeration
typedef enum logic [1:0] {
    BYTE1,
    BYTE2,
    BYTE3,
    DONE
} state_type;

// Define state register and initialize to BYTE1 state
reg state_type current_state = BYTE1;

// Define next state register
reg state_type next_state;

// Define signal to hold the value of the third bit of input
wire third_bit = in[2];

// Define done signal
assign done = (current_state == DONE);

// Sequential logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= BYTE1;
    end else begin
        current_state <= next_state;
    end
end

// Combinational logic
always @(*) begin
    case (current_state)
        BYTE1:
            if (third_bit) begin
                next_state = BYTE2;
            end else begin
                next_state = BYTE1;
            end
        BYTE2:
            next_state = BYTE3;
        BYTE3:
            next_state = DONE;
        DONE:
            if (third_bit) begin
                next_state = BYTE2;
            end else begin
                next_state = BYTE1;
            end
        default:
            next_state = BYTE1;
    endcase
end

endmodule
