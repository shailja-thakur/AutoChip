module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

// State definition
typedef enum logic [1:0] {
    IDLE,
    BYTE_1,
    BYTE_2,
    BYTE_3
} state_t;

// State and output variables
state_t state;
logic done_next;

 always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        done_next <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (in[3] == 1) begin
                    done_next <= 0;
                    state <= BYTE_1;
                end else begin
                    done_next <= 0;
                    state <= IDLE;
                end
            end
            BYTE_1: begin
                done_next <= 0;
                state <= BYTE_2;
            end
            BYTE_2: begin
                done_next <= 0;
                state <= BYTE_3;
            end
            BYTE_3: begin
                done_next <= 1;
                state <= IDLE;
            end
            default: state <= IDLE;
        endcase
    end
end

assign done = done_next;

endmodule
