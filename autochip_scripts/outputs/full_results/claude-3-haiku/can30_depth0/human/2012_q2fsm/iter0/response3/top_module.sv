module top_module (
    input clk,
    input reset,
    input w,
    output z
);

// Assign state codes
localparam A = 3'b000;
localparam B = 3'b001;
localparam C = 3'b010;
localparam D = 3'b011;
localparam E = 3'b100;
localparam F = 3'b101;

// State register
reg [2:0] state;

// State table (combinational)
always @(*) begin
    case (state)
        A: begin
            if (w) state = B;
            else   state = A;
        end
        B: begin
            if (w) state = C;
            else   state = D;
        end
        C: begin
            if (w) state = E;
            else   state = D;
        end
        D: begin
            if (w) state = F;
            else   state = A;
        end
        E: begin
            if (w) state = E;
            else   state = D;
        end
        F: begin
            if (w) state = C;
            else   state = D;
        end
    endcase
end

// State flip-flops (sequential)
always @(posedge clk) begin
    if (reset) state <= A;
    else       state <= state;
end

// Output logic
assign z = (state == E) || (state == F);

endmodule
