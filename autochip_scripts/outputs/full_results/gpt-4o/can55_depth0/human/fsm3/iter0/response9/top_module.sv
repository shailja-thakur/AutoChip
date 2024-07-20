module top_module (
	input clk,
	input in,
	input areset,
	output out
);

    // State encoding
    typedef enum logic [1:0] {
        A = 2'd0,
        B = 2'd1,
        C = 2'd2,
        D = 2'd3
    } state_t;

    state_t state, next_state;

    // State transition logic (combinational)
    always_comb begin
        case (state)
            A: 
                if (in)
                    next_state = B;
                else
                    next_state = A;
            B: 
                if (in)
                    next_state = B;
                else
                    next_state = C;
            C: 
                if (in)
                    next_state = D;
                else
                    next_state = A;
            D: 
                if (in)
                    next_state = B;
                else
                    next_state = C;
            default:
                next_state = A;
        endcase
    end

    // State register (sequential)
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic (combinational)
    assign out = (state == D);

endmodule
