module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

// Declare a temporary signal to hold the previous value of 'a'
reg a_prev;

always @(posedge clock)begin
    a_prev <= a; // Store current value of 'a' in 'a_prev'
    
    if (a_prev == 0 && a == 1)begin
        p <= 1; // Set 'p' to 1 when input 'a' transitions from 0 to 1
    end else if (a_prev == 1 && a == 0)begin
        q <= 1; // Set 'q' to 1 when input 'a' transitions from 1 to 0
    end else begin
        p <= 0;
        q <= 0;
    end
end

endmodule
