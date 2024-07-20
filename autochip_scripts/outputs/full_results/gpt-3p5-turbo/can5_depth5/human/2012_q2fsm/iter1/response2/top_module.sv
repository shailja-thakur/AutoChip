module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

// Define state codes
parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter E = 3'b100;
parameter F = 3'b101;

reg [2:0] state, next_state;

// State table
always @(state, w) begin
    case(state)
        A: begin
            if(w)
                next_state = B;
            else
                next_state = A;
        end
        B: begin
            if(w)
                next_state = C;
            else
                next_state = D;
        end
        C: begin
            if(w)
                next_state = E;
            else
                next_state = D;
        end
        D: begin
            if(w)
                next_state = F;
            else
                next_state = A;
        end
        E: begin
            if(w)
                next_state = E;
            else
                next_state = D;
        end
        F: begin
            if(w)
                next_state = C;
            else
                next_state = D;
        end
    endcase
end

// State flip-flops
always @(posedge clk, posedge reset) begin
    if(reset)
        state <= A;
    else
        state <= next_state;
end

// Assign output
always @(state) begin
    case(state)
        E: z = 1;
        default: z = 0;
    endcase
end

endmodule
