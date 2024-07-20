module top_module (
    input clk,
    input reset,
    input w,
    output z
);
    
reg [2:0] state;
wire [2:0] next_state;

// Define states
parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter E = 3'b100;
parameter F = 3'b101;

// Define state transitions
always @(posedge clk, negedge reset) begin
    if (reset == 0) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

// Define next state logic
always @(*) begin
    case (state)
        A: begin
            if (w == 0)
                next_state = B;
            else
                next_state = A;
        end
        B: begin
            if (w == 0)
                next_state = C;
            else
                next_state = D;
        end
        C: begin
            if (w == 0)
                next_state = E;
            else
                next_state = D;
        end
        D: begin
            if (w == 0)
                next_state = F;
            else
                next_state = A;
        end
        E: begin
            if (w == 0)
                next_state = E;
            else
                next_state = D;
        end
        F: begin
            if (w == 0)
                next_state = C;
            else
                next_state = D;
        end
    endcase
end

// Define output logic
always @(state) begin
    case (state)
        A, B, C, D, F: z = 0;
        E: z = 1;
    endcase
end

endmodule
