module top_module (
    input clk,
    input resetn,
    input [2:0] r,
    output [2:0] g
);

reg [1:0] state, next_state;
wire g1, g2, g3;

parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

// State decoding logic
always @*
begin
    case(state)
        A:
            begin
                if(r[2] == 1'b1) // r2 = 1
                    next_state = C;
                else if(r[1] == 1'b1) // r1 = 1
                    next_state = B;
                else if(r[2:1] == 2'b00) // r2 = 0, r1 = 0
                    next_state = D;
                else
                    next_state = A; // Default state
            end
        B:
            begin
                if(g1 == 1'b1) // g1 = 1
                    next_state = B;
                else
                    next_state = A; // Default state
            end
        C:
            begin
                if(g2 == 1'b1) // g2 = 1
                    next_state = C;
                else
                    next_state = A; // Default state
            end
        default:
            next_state = A;
    endcase
end

// State flip-flops
always @(posedge clk or negedge resetn)
begin
    if(!resetn)
        state <= A;
    else
        state <= next_state;
end

// Output assignment
always @*
begin
    case(state)
        A:
            begin
                g1 = 1'b1;
                g2 = 1'b0;
                g3 = 1'b0;
            end
        B:
            begin
                g1 = 1'b0;
                g2 = 1'b0;
                g3 = 1'b0;
            end
        C:
            begin
                g1 = 1'b0;
                g2 = 1'b1;
                g3 = 1'b0;
            end
        D:
            begin
                g1 = 1'b0;
                g2 = 1'b0;
                g3 = 1'b0;
            end
        default:
            begin
                g1 = 1'b0;
                g2 = 1'b0;
                g3 = 1'b0;
            end
    endcase
end

assign g = {g3, g2, g1};

endmodule
