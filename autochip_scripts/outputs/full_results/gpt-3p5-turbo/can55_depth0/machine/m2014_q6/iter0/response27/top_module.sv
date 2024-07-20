module top_module (
    input clk,
    input reset,
    input w,
    output z
);

// Define the states
parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter E = 3'b100;
parameter F = 3'b101;

// Define the internal state register and the next state
reg [2:0] state;
reg [2:0] next_state;

// State transition and output logic
always @(posedge clk) begin
    if (reset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
    
    case (state)
        A: begin
            if (w == 1'b0) begin
                next_state = B;
            end else begin
                next_state = A;
            end
        end
        
        B: begin
            if (w == 1'b1) begin
                next_state = D;
            end else begin
                next_state = C;
            end
        end
        
        C: begin
            if (w == 1'b1) begin
                next_state = D;
            end else begin
                next_state = E;
            end
        end
        
        D: begin
            if (w == 1'b1) begin
                next_state = A;
            end else begin
                next_state = F;
            end
        end
        
        E: begin
            if (w == 1'b1) begin
                next_state = D;
            end else begin
                next_state = E;
            end
        end
        
        F: begin
            if (w == 1'b1) begin
                next_state = D;
            end else begin
                next_state = C;
            end
        end
    endcase
end

// Output logic
assign z = (state == E || state == F) ? 1'b1 : 1'b0;

endmodule
