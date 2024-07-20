module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

// Define the states
parameter A = 6'b000001;
parameter B = 6'b000010;
parameter C = 6'b000100;
parameter D = 6'b001000;
parameter E = 6'b010000;
parameter F = 6'b100000;

// Define the next-state signals
reg [6:1] next_y;
always @(y) begin
    case(y)
        A: begin
            if(w)
                next_y = D;
            else
                next_y = B;
        end
        B: begin
            if(w)
                next_y = D;
            else
                next_y = C;
        end
        C: begin
            if(w)
                next_y = D;
            else
                next_y = E;
        end
        D: begin
            if(w)
                next_y = A;
            else
                next_y = F;
        end
        E: begin
            if(w)
                next_y = D;
            else
                next_y = E;
        end
        F: begin
            if(w)
                next_y = D;
            else
                next_y = C;
        end
        default: next_y = A;
    endcase
end

// Assign the next-state signals to the output ports
assign Y2 = next_y[2];
assign Y4 = next_y[4];

endmodule
