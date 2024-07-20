module top_module(
    input clk,
    input d,
    output reg q
);

    reg qp; // Register to store the value of 'd' on positive edge of clock
    reg qn; // Register to store the value of 'd' on negative edge of clock

    always @(posedge clk) begin
        qp <= d; // Update qp with the value of 'd' on positive edge of clock
    end

    always @(negedge clk) begin
        qn <= d; // Update qn with the value of 'd' on negative edge of clock
    end

    always @(*) begin
        if (clk) begin
            q <= qp; // Assign the value of qp to the output 'q' when clock is high
        end else begin
            q <= qn; // Assign the value of qn to the output 'q' when clock is low
        end
    end

endmodule
