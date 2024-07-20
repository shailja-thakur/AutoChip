module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Intermediate wires
    wire sop0, sop1, pos0, pos1;
    
    // Generate the SOP output
    assign sop0 = c & d;
    assign sop1 = (~a & ~b & c);
    assign out_sop = sop0 | sop1;
    
    // Generate the POS outputs
    assign pos0 = c & (~b | d) & (~a | b);
    assign pos1 = c & (~a | d);
    
    // Handle unknown output for out_pos
    wire out_pos_tmp;
    assign out_pos_tmp = (pos0 === pos1) ? pos0 : 1'bx;
    
    // Synchronize out_pos output
    reg [1:0] out_pos_reg;
    always @(posedge clk) begin
        if (reset) begin
            out_pos_reg <= 2'b0;
        end else begin
            out_pos_reg <= out_pos_tmp;
        end
    end
    
    // Assign synchronized out_pos to output
    assign out_pos = out_pos_reg;
    
endmodule
