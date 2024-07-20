module top_module (
    input clk,
    input areset,
    input x,
    output z
);
   
reg [3:0] state;
reg [3:0] next_state;
reg [3:0] complement;

always @(posedge clk or negedge areset) begin
    if (areset == 0) begin
        state <= 4'b0000;   // reset state
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        4'b0000: begin   // Idle state
            if (areset == 0) begin
                next_state = 4'b0000;
            end else if (x == 1'b1) begin
                next_state = 4'b0001;   // Complement state
            end else begin
                next_state = 4'b0000;
            end
        end
        
        4'b0001: begin   // Complement state
            if (areset == 0) begin
                next_state = 4'b0000;
            end else if (x == 1'b0) begin
                next_state = 4'b0001;   // Stay in complement state
            end else begin
                next_state = 4'b0010;   // Output state
            end
        end
        
        4'b0010: begin   // Output state
            if (areset == 0) begin
                next_state = 4'b0000;
            end else begin
                next_state = 4'b0000;   // Return to idle state
            end
        end
    endcase
end

always @(posedge clk) begin
    if (areset == 1'b0) begin
        complement <= 4'b0000;   // reset complement 
    end else if (state == 4'b0001) begin
        complement <= ~x + 1;   // calculate complement
    end
end

assign z = (state == 4'b0010) ? complement : x;

endmodule
