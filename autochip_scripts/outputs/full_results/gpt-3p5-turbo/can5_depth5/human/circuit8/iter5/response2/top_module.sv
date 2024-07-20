module top_module (
    input wire clock,
    input wire a, 
    output reg p,
    output reg q
);

reg prev_a;
reg [2:0] state;

always @(posedge clock) begin
    prev_a <= a;
    
    case (state)
        3'b000:  // Initial state
            if (a == 1'b0) begin
                state <= 3'b001;
                p <= 1'b0;
                q <= 1'b0;
            end
        3'b001:  // State where a = 0, p and q are 0
            if (a == 1'b0) begin
                state <= 3'b010;
                p <= 1'b0;
                q <= 1'b0;
            end
        3'b010:  // State where a = 0, p and q are 0
            if (a == 1'b0) begin
                state <= 3'b011;
                p <= 1'b0;
                q <= 1'b0;
            end
        3'b011:  // State where a = 0, p and q are 0
            if (a == 1'b0) begin
                state <= 3'b100;
                p <= 1'b0;
                q <= 1'b0;
            end
        3'b100:  // State where a = 0, p and q are 0
            if (a == 1'b0) begin
                state <= 3'b101;
                p <= 1'b0;
                q <= 1'b0;
            end
        3'b101:  // State where a = 0, p and q are 0
            if (a == 1'b0) begin
                state <= 3'b110;
                p <= 1'b0;
                q <= 1'b0;
            end
        3'b110:  // State where a = 1, p and q are 0
            if (a == 1'b0) begin
                state <= 3'b111;
                p <= 1'b0;
                q <= 1'b0;
            end
            else if (prev_a == 1'b1) begin
                state <= 3'b000;
                p <= 1'b0;
                q <= 1'b0;
            end
        3'b111:  // State where a = 1, p and q are 0
            if (a == 1'b0) begin
                state <= 3'b000;
                p <= 1'b0;
                q <= 1'b0;
            end
            else begin
                state <= 3'b001;
                p <= 1'b1;
                q <= 1'b1;
            end
    endcase
end

endmodule
