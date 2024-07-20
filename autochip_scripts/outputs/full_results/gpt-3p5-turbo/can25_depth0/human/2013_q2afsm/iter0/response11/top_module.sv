module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

// Define states using an enum
typedef enum logic [1:0] {
    STATE_A,
    STATE_B,
    STATE_C,
    STATE_D
} state_t;

// Define signals and state variable
logic [1:0] current_state, next_state;
logic [3:1] g_next;

// State flip-flops
always_ff @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        current_state <= STATE_A;
    end else begin
        current_state <= next_state;
    end
end

// State table
always_comb begin
    case (current_state)
        STATE_A: begin
            if (r[1]) begin
                next_state = STATE_B;
                g_next = 3'b001;
            end else if (r[2]) begin
                next_state = STATE_C;
                g_next = 3'b010;
            end else if (r[3]) begin
                next_state = STATE_D;
                g_next = 3'b100;
            end else begin
                next_state = STATE_A;
                g_next = 3'b000;
            end
        end
        
        STATE_B: begin
            if (r[1]) begin
                next_state = STATE_B;
                g_next = 3'b001;
            end else if (r[2]) begin
                next_state = STATE_A;
                g_next = 3'b000;
            end else begin
                next_state = STATE_B;
                g_next = 3'b001;
            end
        end
        
        STATE_C: begin
            if (r[1]) begin
                next_state = STATE_A;
                g_next = 3'b000;
            end else if (r[2]) begin
                next_state = STATE_C;
                g_next = 3'b010;
            end else begin
                next_state = STATE_C;
                g_next = 3'b010;
            end
        end
        
        STATE_D: begin
            if (r[1] || r[2] || r[3]) begin
                next_state = STATE_D;
                g_next = 3'b100;
            end else begin
                next_state = STATE_A;
                g_next = 3'b000;
            end
        end
    endcase
    
    // Assign outputs
    g = g_next;
end

endmodule
