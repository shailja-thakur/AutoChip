module top_module (
     input clk,
     input resetn,
     input x,
     input y,
     output f,
     output g
);
    
    reg [3:0] state, next_state;
    reg [1:0] f_state, g_state;
    
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= 4'b0000;
        else
            state <= next_state;
    end
    
    always @* begin
        f_state = state[1] | state[2] | state[3];
        g_state = (state == 4'b0101) | (state == 4'b0110) | (state == 4'b1000);
    end
    
    always @* begin
        case(state)
            4'b0000: begin // A
                next_state = 4'b0100; // B
            end
            4'b0100: begin // B
                next_state = 4'b0001; // S0
            end
            4'b0001: begin // S0
                if (x)
                    next_state = 4'b0010; // S1
                else
                    next_state = 4'b0001; // S0
            end
            4'b0010: begin // S1
                if (x)
                    next_state = 4'b0010; // S1
                else
                    next_state = 4'b1010; // S10
            end
            4'b1010: begin // S10
                if (x)
                    next_state = 4'b1101; // G1
                else
                    next_state = 4'b0001; // S0
            end
            4'b1101: begin // G1
                if (y)
                    next_state = 4'b1111; // P1
                else
                    next_state = 4'b0111; // G2
            end
            4'b0111: begin // G2
                if (y)
                    next_state = 4'b1111; // P1
                else
                    next_state = 4'b1000; // P0
            end
            4'b1000: begin // P0
                next_state = 4'b1000; // P0
            end
            4'b1111: begin // P1
                next_state = 4'b1111; // P1
            end
        endcase
    end
    
    assign f = (f_state == 2'b10); // f is assigned to 1 when the state is B
    assign g = (g_state == 1'b1); // g is assigned to 1 when the state is G1 or G2 or P1

endmodule
