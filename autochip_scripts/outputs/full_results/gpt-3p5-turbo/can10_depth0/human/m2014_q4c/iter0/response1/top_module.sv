module top_module (
    input clk,
    input d,
    input r,
    output logic q
);
	
    logic q_temp;
    
    always_ff @ (posedge clk or posedge r) begin
        if (r) begin
            q_temp <= 0;
        end else begin
            q_temp <= d;
        end
    end
    
    assign q = q_temp;
    
endmodule
