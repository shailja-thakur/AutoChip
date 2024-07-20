module top_module (
    input [6:1] y,
    input w,
    output reg Y2,
    output reg Y4
);

    // Declare intermediate signals
    wire y2_wire;
    wire y4_wire;
    
    assign y2_wire = (y[6:1] == 7'b000001) && ~w;
    assign y4_wire = (y[6:1] == 7'b000010) && ~w;
    
    always @(posedge clk) begin
        if (w) begin
            Y2 <= y2_wire;
            Y4 <= y4_wire;
        end
    end
    
endmodule
