module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    reg [1:0] state;
    wire [1:0] next_state;

    // Define the next state and output based on the current state and input
    always @(state or x) begin
        case(state)
            2'b00: begin
                if(x)
                    next_state = 2'b01;
                else
                    next_state = 2'b00;
                z = x;
            end

            2'b01: begin
                if(x)
                    next_state = 2'b00;
                else
                    next_state = 2'b01;
                z = ~x;
            end
        endcase
    end

    // Synchronous state update
    always @(posedge clk or posedge areset) begin
        if(areset)
            state <= 2'b00;
        else
            state <= next_state;
    end

endmodule
