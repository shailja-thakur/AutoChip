module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // State definition
    reg [1:0] state, next_state;
    localparam OFF = 2'b00;
    localparam ON = 2'b01;
    
    // Reset logic
    always @ (posedge clk or posedge areset) begin
        if (areset)
            state <= OFF;
        else
            state <= next_state;
    end
    
    // State transition and output logic
    always @* begin
        case (state)
            OFF: begin
                if (j)
                    next_state = ON;
                else
                    next_state = OFF;
                out = 1'b0;
            end
            
            ON: begin
                if (k)
                    next_state = OFF;
                else
                    next_state = ON;
                out = 1'b1;
            end
        endcase
    end
endmodule
