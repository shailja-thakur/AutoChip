module top_module (
    input clk,
    input x,
    output reg z
);

    // Flip-flop outputs
    reg d_reg;

    // Logic gates
    wire xor_out;
    wire and_out;
    wire or_out;

    // Flip-flops
    always @(posedge clk) begin
        d_reg <= x;
    end

    // Logic gates
    assign xor_out = xor(d_reg, d_reg);
    assign and_out = and(~d_reg, d_reg);
    assign or_out = or(~d_reg, d_reg);

    // XNOR gate
    assign z = xnor(xor_out, and_out, or_out);

    // Primitive Gates
    // XOR gate
    function xor;
        input a;
        input b;
        begin
            xor = (!a & b) | (a & !b);
        end
    endfunction

    // AND gate
    function and;
        input a;
        input b;
        begin
            and = a & b;
        end
    endfunction

    // OR gate
    function or;
        input a;
        input b;
        begin
            or = a | b;
        end
    endfunction

    // XNOR gate
    function xnor;
        input a;
        input b;
        input c;
        begin
            xnor = (!a & !b & !c) | (!a & b & c) | (a & !b & c) | (a & b & !c);
        end
    endfunction

endmodule
