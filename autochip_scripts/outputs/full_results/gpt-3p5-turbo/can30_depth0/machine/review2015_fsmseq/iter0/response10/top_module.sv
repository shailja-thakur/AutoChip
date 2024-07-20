module top_module(
    input clk,
    input reset,
    input data,
    output start_shifting);

    reg [2:0] state;
    wire next_state;

    always@(posedge clk or posedge reset) begin
        if (reset)
            state <= 3'b000;
        else
            state <= next_state;
    end

    assign next_state = getNextState(state, data);

    always@(state) begin
        case(state)
            3'b000: start_shifting <= 1'b0;
            3'b001: start_shifting <= 1'b0;
            3'b010: start_shifting <= 1'b0;
            3'b011: start_shifting <= 1'b1;
            3'b100: start_shifting <= 1'b0;
        endcase
    end

    function getNextState(input_state, input_data);
        input [2:0] input_state;
        input input_data;
        reg [2:0] next_state;
        
        case(input_state)
            3'b000: begin
                if (input_data)
                    next_state = 3'b001;
                else
                    next_state = 3'b000;
            end
            3'b001: begin
                if (input_data)
                    next_state = 3'b010;
                else
                    next_state = 3'b000;
            end
            3'b010: begin
                if (input_data)
                    next_state = 3'b010;
                else
                    next_state = 3'b011;
            end
            3'b011: begin
                if (input_data)
                    next_state = 3'b010;
                else
                    next_state = 3'b100;
            end
            3'b100: begin
                if (input_data)
                    next_state = 3'b100;
                else
                    next_state = 3'b000;
            end
        endcase

        getNextState = next_state;
    endfunction

endmodule
