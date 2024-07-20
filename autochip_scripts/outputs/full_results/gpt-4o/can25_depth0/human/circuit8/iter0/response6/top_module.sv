module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

reg [1:0] state;  // State register to track the current state

// State encoding
localparam S0 = 2'b00;
localparam S1 = 2'b01;
localparam S2 = 2'b10;
localparam S3 = 2'b11;

always @(posedge clock) begin
    case (state)
        S0: begin
            // Initial state
            p <= 0;
            if (a) state <= S1;
        end
        S1: begin
            // When `a` is high, `p` becomes 1
            p <= 1;
            if (!a) state <= S2;
        end
        S2: begin
            // Maintain the state if `a` goes low
            if (a) state <= S3;
        end
        S3: begin
            // Back to initial state
            p <= 0;
            if (!a) state <= S0;
        end
    endcase
end

always @(negedge clock) begin
    if (p == 0 && state == S0) begin
        q <= 0;
    end else begin
        q <= p;
    end
end

always @(posedge clock or negedge clock) begin
    if (!clock) begin
        if (state == S0 && p == 0) q <= 0;
        if (a) p <= 1;
        if (p == 1 && state == S3) p <= 0;
    end
end

endmodule
