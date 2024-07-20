module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output wire f,
    output wire g
);

    // Declare the state variables and their values
    reg [3:0] current_state;
    parameter A = 0, B = 1, S0 = 2, S1 = 3, S10 = 4, G1 = 5, G2 = 6, P0 = 7, P1 = 8;
    
    always @ (posedge clk or negedge resetn) begin
        if (!resetn) begin
            current_state <= A;
        end else begin
            case(current_state)
                A: if (x) current_state <= B; else current_state <= A;
                B: if (x) current_state <= S0; else current_state <= A;
                S0: if (x) current_state <= S1; else current_state <= S0;
                S1: if (x) current_state <= S1; else current_state <= S10;
                S10: if (x) current_state <= G1; else current_state <= S0;
                G1: if (y) current_state <= P1; else current_state <= G2;
                G2: if (y) current_state <= P1; else current_state <= P0;
                P0: current_state <= P0;
                P1: current_state <= P1;
                default: current_state <= A;
            endcase
        end
    end

    always @ (current_state) begin
        case(current_state)
            B: f = 1'b1;
            default: f = 1'b0;
        endcase
    end

    always @ (current_state) begin
        case(current_state)
            G1, G2, P1: g = 1'b1;
            default: g = 1'b0;
        endcase
    end

endmodule
