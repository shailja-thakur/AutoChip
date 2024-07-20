module top_module (
	input clk,
	input reset,
	input w,
	output z
);

// Define state enum
typedef enum logic [2:0] {
    A,
    B,
    C,
    D,
    E,
    F
} state_t;

// Define internal signals
reg [2:0] current_state;
reg [2:0] next_state;

// Define state table
always_comb begin
    case (current_state)
        A: if (w) next_state = B; else next_state = A;
        B: if (w) next_state = C; else next_state = D;
        C: if (w) next_state = E; else next_state = D;
        D: if (w) next_state = F; else next_state = A;
        E: if (w) next_state = E; else next_state = D;
        F: if (w) next_state = C; else next_state = D;
    endcase
end

// Define state flip-flops
always_ff @(posedge clk, posedge reset) begin
    if (reset) begin
        current_state <= A;
    end else begin
        current_state <= next_state;
    end
end

// Define output assignment
always_comb begin
    case (current_state)
        E: z = 1;
        default: z = 0;
    endcase
end

endmodule
