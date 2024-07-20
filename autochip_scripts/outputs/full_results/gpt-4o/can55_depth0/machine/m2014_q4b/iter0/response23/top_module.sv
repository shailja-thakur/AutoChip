module top_module (
    input clk,
    input d,
    input ar,
    output logic q
);

// Register to hold the state of q
logic q_reg;

// Combinational logic to continuously assign q from q_reg
assign q = q_reg;

always_ff @(posedge clk or posedge ar) begin
    if (ar) begin
        q_reg <= 1'b0; // asynchronously reset q to 0
    end else begin
        q_reg <= d; // assign the input d to q on clock's rising edge
    end
end

endmodule
