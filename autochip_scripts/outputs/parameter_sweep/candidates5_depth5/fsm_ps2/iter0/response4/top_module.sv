module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

// State enumeration
typedef enum logic [1:0] {
    IDLE,
    BYTE1,
    BYTE2,
    BYTE3
} state;

// Registers
reg [1:0] current_state;
reg [1:0] next_state;
reg done_reg;

// Combinational logic
always_comb begin
    next_state = current_state;
    
    case (current_state)
        IDLE: begin
            if (in[3] == 1) begin
                next_state = BYTE1;
            end else begin
                next_state = IDLE;
            end
        end
        BYTE1: begin
            next_state = BYTE2;
        end
        BYTE2: begin
            next_state = BYTE3;
        end
        BYTE3: begin
            next_state = IDLE;
        end
        default: next_state = IDLE;
    endcase
end

// Sequential logic
always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= IDLE;
        done_reg <= 0;
    end else begin
        current_state <= next_state;
        if (current_state == BYTE3) begin
            done_reg <= 1;
        end
    end
end

// Output assignment
assign done = done_reg;

endmodule
