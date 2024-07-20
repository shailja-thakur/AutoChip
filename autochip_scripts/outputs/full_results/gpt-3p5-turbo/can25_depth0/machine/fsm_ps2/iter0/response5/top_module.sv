module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

// Define state enumeration
typedef enum logic [1:0] {
    BYTE1, BYTE2, BYTE3, DONE
} state_t;

// Instantiate state register and assign initial state
reg [1:0] current_state;
initial current_state = BYTE1;

// Instantiate output register
reg done_reg;
assign done = done_reg;

// Define next state logic
always_ff @(posedge clk, posedge reset) begin
    if (reset) begin
        current_state <= BYTE1;
    end else begin
        case (current_state)
            BYTE1: begin
                if (in[2] == 1) begin
                    current_state <= BYTE2;
                end else begin
                    current_state <= BYTE1;
                end
            end
            BYTE2: begin
                current_state <= BYTE3;
            end
            BYTE3: begin
                current_state <= DONE;
            end
            DONE: begin
                if (in[2] == 0) begin
                    current_state <= BYTE1;
                end else begin
                    current_state <= BYTE2;
                end
            end
        endcase
    end
end

// Define output logic
always_comb begin
    done_reg = (current_state == DONE);
end

endmodule
