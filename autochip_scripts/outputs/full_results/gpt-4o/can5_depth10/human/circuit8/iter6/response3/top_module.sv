module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    // Registers to hold intermediate states
    reg next_p;

    // Sequential logic
    always @(posedge clock) begin
        if (a) begin
            next_p <= 1;
        end else begin
            next_p <= 0;
        end
    end

    always @(posedge clock or negedge clock) begin
        if (clock) begin
            p <= next_p;
        end else begin
            q <= p;
        end
    end
    
endmodule
