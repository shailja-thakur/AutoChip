module top_module (
	input clk,
	input areset,
	input x,
	output z
);
    // State enumeration
    typedef enum logic [1:0] {A, B} state_t;
    
    // State and output signals
    logic [1:0] state;
    logic z;
    
    always_ff @(posedge clk or negedge areset)
    begin
        if (!areset)
            state <= A;
        else
        begin
            case (state)
                A: if (x) state <= B;
                   else state <= A;
                B: state <= B;
            endcase
        end
    end
    
    always_comb
    begin
        case (state)
            A: if (x) z = 1;
               else z = 0;
            B: if (!x) z = 1;
               else z = 0;
        endcase
    end
    
endmodule
