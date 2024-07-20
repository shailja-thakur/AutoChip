module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);
    
    always @(posedge clk) begin
        if(load) begin
            q <= data;
        end
        else begin
            q <= next_state(q);
        end
    end

    function bit cell_rule(bit self, bit [7:0] neighbors);
        case(neighbors)
            0, 1: cell_rule = 0;
            2: cell_rule = self;
            3: cell_rule = 1;
            4, 5, 6, 7, 8: cell_rule = 0;
        endcase
    endfunction

    function [255:0] next_state(input [255:0] current_state);
        reg [255:0] next_state;
        reg [3:0] i, j;
        for(i=0; i<16; i=i+1) begin
            for(j=0; j<16; j=j+1) begin
                next_state[i*16+j] = cell_rule(
                    current_state[i*16+j],
                    current_state[((i-1)&15)*16+((j-1)&15)], 
                    current_state[((i-1)&15)*16+j], 
                    current_state[((i-1)&15)*16+((j+1)&15)], 
                    current_state[i*16+((j-1)&15)], 
                    current_state[i*16+((j+1)&15)], 
                    current_state[((i+1)&15)*16+((j-1)&15)], 
                    current_state[((i+1)&15)*16+j], 
                    current_state[((i+1)&15)*16+((j+1)&15)]
                );
            end
        end
        next_state;
    endfunction

endmodule
