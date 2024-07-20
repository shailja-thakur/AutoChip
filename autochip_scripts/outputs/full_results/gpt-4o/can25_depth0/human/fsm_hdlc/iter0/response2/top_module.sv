module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

    // State encoding
    typedef enum reg [3:0] {
        S0,  // initial state, last bit seen was 0
        S1,  // last 1 was seen 1
        S2,  // last two 1s were seen 11
        S3,  // last three 1s were seen 111
        S4,  // last four 1s were seen 1111
        S5,  // last five 1s were seen 11111
        S6,  // last six 1s were seen 111111
        S7   // last seven 1s were seen 1111111
    } state_t;
    
    state_t current_state, next_state;

    always @ (posedge clk) begin
        if (reset) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    always @ (*) begin
        // Default output values
        disc = 0;
        flag = 0;
        err = 0;

        case (current_state)
            S0: begin
                if (in) 
                    next_state = S1;
                else 
                    next_state = S0;
            end
            
            S1: begin
                if (in) 
                    next_state = S2;
                else 
                    next_state = S0;
            end
            
            S2: begin
                if (in) 
                    next_state = S3;
                else 
                    next_state = S0;
            end
            
            S3: begin
                if (in) 
                    next_state = S4;
                else 
                    next_state = S0;
            end
            
            S4: begin
                if (in) 
                    next_state = S5;
                else 
                    next_state = S0;
            end
            
            S5: begin
                if (in) 
                    next_state = S6;
                else begin
                    next_state = S0;
                    disc = 1;
                end
            end
            
            S6: begin
                if (in) 
                    next_state = S7;
                else begin
                    next_state = S0;
                    flag = 1;
                end
            end
            
            S7: begin
                if (in) 
                    next_state = S7;
                else 
                    next_state = S0;
                err = 1;
            end
        endcase
    end

endmodule
