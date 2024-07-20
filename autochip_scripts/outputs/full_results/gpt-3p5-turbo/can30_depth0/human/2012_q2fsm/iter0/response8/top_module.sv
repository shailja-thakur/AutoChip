module top_module(
    input clk,
    input reset,
    input w,
    output z
);

// Define states
parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter E = 3'b100;
parameter F = 3'b101;

// Define output values
wire output_value;

// State register
reg [2:0] state_reg, state_next;

// State transition logic
always @(posedge clk or posedge reset) begin
    if (reset)
        state_reg <= A;
    else
        state_reg <= state_next;
end

// State table logic
always @* begin
    case (state_reg)
        A: begin
            if (w)
                state_next = B;
            else
                state_next = A;
        end
        
        B: begin
            if (w)
                state_next = C;
            else
                state_next = D;
        end
        
        C: begin
            if (w)
                state_next = E;
            else
                state_next = D;
        end
        
        D: begin
            if (w)
                state_next = F;
            else
                state_next = A;
        end
        
        E: begin
            if (w)
                state_next = E;
            else
                state_next = D;
        end
        
        F: begin
            if (w)
                state_next = C;
            else
                state_next = D;
        end
    endcase
end

// Output assignment
always @* begin
    case (state_reg)
        A: output_value = 1'b0;
        B: output_value = 1'b0;
        C: output_value = 1'b0;
        D: output_value = 1'b0;
        E: output_value = 1'b1;
        F: output_value = 1'b1;
    endcase
end

// Assign output
assign z = output_value;

endmodule
