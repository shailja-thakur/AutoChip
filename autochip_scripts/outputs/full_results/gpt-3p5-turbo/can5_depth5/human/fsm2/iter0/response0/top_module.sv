module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

    reg [1:0] state;
    wire next_state;
    
    // Define states
    parameter OFF = 2'b00;
    parameter ON = 2'b01;
    
    // Define outputs
    assign out = (state == ON) ? 1'b1 : 1'b0;
    
    // Define the state transition logic
    always @(posedge clk or posedge areset) begin
        if (areset == 1'b1) begin
            state <= OFF;
        end else begin
            state <= next_state;
        end
    end
    
    // Define the next state logic
    always @(*) begin
        case (state)
            OFF: begin
                if (j == 1'b1) begin
                    next_state = ON;
                end else begin
                    next_state = OFF;
                end
            end
            ON: begin
                if (k == 1'b1) begin
                    next_state = OFF;
                end else begin
                    next_state = ON;
                end
            end
        endcase
    end
    
endmodule
