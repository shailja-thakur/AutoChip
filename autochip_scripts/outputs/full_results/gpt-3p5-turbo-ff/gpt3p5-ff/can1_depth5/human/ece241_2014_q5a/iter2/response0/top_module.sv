module top_module (
    input clk,
    input areset,
    input x,
    output z
);
   
reg signed [31:0] complement;
reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk or negedge areset) begin
    if (areset == 0) begin
        state <= 2'b00;   // reset state
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        2'b00: begin   // Idle state
            if (areset == 0) begin
                next_state = 2'b00;
            end else if (x == 1'b1) begin
                next_state = 2'b01;   // Complement state
            end else begin
                next_state = 2'b00;
            end
        end
        
        2'b01: begin   // Complement state
            if (areset == 0) begin
                next_state = 2'b00;
            end else if (x == 1'b0) begin
                next_state = 2'b01;   // Stay in complement state
            end else begin
                next_state = 2'b10;   // Output state
            end
        end
        
        2'b10: begin   // Output state
            if (areset == 0) begin
                next_state = 2'b00;
            end else begin
                next_state = 2'b00;   // Return to idle state
            end
        end
    endcase
end

always @(posedge clk) begin
    if (areset == 1'b0) begin
        complement <= 32'b0;   // reset complement 
    end else if (state == 2'b01) begin
        complement <= -x;   // calculate 2's complement
    end
end

assign z = (state == 2'b10) ? complement : 32'b0;

endmodule
